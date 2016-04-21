# -*- coding: utf-8 -*-
from threading import Thread
from time import sleep
import random

from django.contrib.auth.models import User, Group
from django.http import HttpResponse
from django.views.generic.base import TemplateView
from django.views.decorators.csrf import csrf_exempt
from ws4redis.redis_store import RedisMessage
from ws4redis.publisher import RedisPublisher


class BroadcastChatView(TemplateView):
    template_name = 'broadcast_chat.html'

    def __init__(self, *args, **kwargs):
        super(BroadcastChatView, self).__init__(*args, **kwargs)
        self.redis_publisher = RedisPublisher(facility='foobar', broadcast=True)

    def get(self, request, *args, **kwargs):
        self.redis_publisher.publish_message(RedisMessage('Hello everybody'))

        thread = Thread(target=self.thread_function, args=(10,))
        thread.start()

        return super(BroadcastChatView, self).get(request, *args, **kwargs)

    def thread_function(self, arg):
        for i in range(arg):
            sleep_time = random.randint(1, 10)
            message = RedisMessage('[%d/%d] Long task which takes %d seconds...' % (i + 1, arg, sleep_time))
            self.redis_publisher.publish_message(message)
            sleep(sleep_time)


class UserChatView(TemplateView):
    template_name = 'user_chat.html'

    def get_context_data(self, **kwargs):
        context = super(UserChatView, self).get_context_data(**kwargs)
        context.update(users=User.objects.all())
        return context

    @csrf_exempt
    def dispatch(self, *args, **kwargs):
        return super(UserChatView, self).dispatch(*args, **kwargs)

    def post(self, request, *args, **kwargs):
        redis_publisher = RedisPublisher(facility='foobar', users=[request.POST.get('user')])
        message = RedisMessage(request.POST.get('message'))
        redis_publisher.publish_message(message)
        return HttpResponse('OK')


class GroupChatView(TemplateView):
    template_name = 'group_chat.html'

    def get_context_data(self, **kwargs):
        context = super(GroupChatView, self).get_context_data(**kwargs)
        context.update(groups=Group.objects.all())
        return context

    @csrf_exempt
    def dispatch(self, *args, **kwargs):
        return super(GroupChatView, self).dispatch(*args, **kwargs)

    def post(self, request, *args, **kwargs):
        redis_publisher = RedisPublisher(facility='foobar', groups=[request.POST.get('group')])
        message = RedisMessage(request.POST.get('message'))
        redis_publisher.publish_message(message)
        return HttpResponse('OK')

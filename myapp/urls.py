from django.conf.urls import url, include

from myapp import views
import socketio.django


urlpatterns = [
    url("^socket\.io", include(socketio.sdjango.urls)),
    url(r'^$', views.index, name='index')
]

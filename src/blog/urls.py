from django.conf.urls import url

from blog import views

urlpatterns = [
    url(r'^(?P<slug>[-\w\d]+)$', views.post, name='post'),
]

from django.conf.urls import patterns, url
from CodeSchool import settings

urlpatterns = patterns('',
    url(r'^$','WebSchool.views.login'),
    url(r'^base_administrator/$','WebSchool.views.base_administrator'),
    url(r'^media/(?P<path>.*)$','django.views.static.serve',
    {'document_root':settings.MEDIA_ROOT,}
    ),
)
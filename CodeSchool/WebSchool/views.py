from django.shortcuts import render_to_response
from django.template.context import RequestContext

def login(request):
    return render_to_response('login.html', context_instance = RequestContext(request))
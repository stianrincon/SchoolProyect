from django.shortcuts import render_to_response
from django.template.context import RequestContext
from django.contrib.auth.forms import AuthenticationForm

def login(request):
    if request.method == 'POST':
        form = AuthenticationForm(request.POST)
    else:
        form = AuthenticationForm()        
    return render_to_response('login.html', {'form':form}, context_instance = RequestContext(request))
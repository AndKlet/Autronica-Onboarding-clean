from django.contrib import admin
from .models import RequestResolver, EmailRequestResolver, APIRequestResolver, Software, Department, Request

admin.site.register(RequestResolver)
admin.site.register(EmailRequestResolver)
admin.site.register(APIRequestResolver)
admin.site.register(Software)
admin.site.register(Department)
admin.site.register(Request)


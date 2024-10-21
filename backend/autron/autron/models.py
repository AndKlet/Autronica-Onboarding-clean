from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType
from django.db import models


# Generic request resolver model for fields that are common to all request resolvers.
# You are not to create an instance of this model directly.
# Instead, you should create an instance of a subclass of this model.
class RequestResolver(models.Model):
    name = models.CharField(max_length=100)

    def handle_request(self, request):
        raise NotImplementedError("Subclasses must implement this method")

    def __str__(self):
        return self.name


# Subclasses of RequestResolver model.
# This resolver will be used for the software that need to send an email to request access.
class EmailRequestResolver(RequestResolver):
    email_address = models.EmailField()
    email_subject = models.CharField(max_length=100)
    email_body = models.TextField()

    def handle_request(self, request):
        # Logic to send an email
        pass


# Subclasses of RequestResolver model.
# This resolver will be used for the software that need to call an external API (servicenow)
# to request access.
class APIRequestResolver(RequestResolver):
    api_endpoint = models.URLField()

    def handle_request(self, request):
        # Logic to call an external API
        pass


# Software model that uses the generic foreign key to link to the resolver model.
class Software(models.Model):
    name = models.CharField(max_length=100)
    department = models.ForeignKey("Department", on_delete=models.CASCADE)
    image = models.ImageField(upload_to="software_images/", null=True, blank=True)
    description = models.CharField(max_length=500, default="No description provided")
    requestmethod = models.CharField(max_length=50, default="No request method defined")
    # resolver_content_type = None
    # resolver_object_id = None
    # resolver = None

    def __str__(self):
        return self.name


# Department model
class Department(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name


# Request model that uses the generic foreign key to link to the resolver model.
class Request(models.Model):
    software = models.ForeignKey(Software, on_delete=models.CASCADE)
    # user = models.ForeignKey("auth.User", on_delete=models.CASCADE)
    # resolver_content_type = None
    # resolver_object_id = None
    # resolver = None
    request_date = models.DateTimeField(auto_now_add=True)
    request_status = models.CharField(max_length=100)

    def __str__(self):
        return self.software.name


# User model
# class User(models.Model):
#     name = models.CharField(max_length=100)
#     email = models.EmailField()
#     department = models.ForeignKey(Department, on_delete=models.CASCADE)

#     def __str__(self):
#         return self.name

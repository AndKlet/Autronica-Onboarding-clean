"""
URL configuration for autron project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from autron import views
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import include, path
from drf_yasg import openapi
from drf_yasg.views import get_schema_view
from rest_framework import permissions

from .views import request_access_view, okta_callback

schema_view = get_schema_view(
    openapi.Info(
        title="Autron API",
        default_version="v1",
        description="API for Autronica onboarding solution",
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)

urlpatterns = [
    path("admin/", admin.site.urls),
    # Swagger UI and Redoc UI
    path(
        "swagger<format>/",
        schema_view.without_ui(cache_timeout=0),
        name="schema-json",
    ),
    path(
        "swagger/",
        schema_view.with_ui("swagger", cache_timeout=0),
        name="schema-swagger-ui",
    ),
    path(
        "redoc/",
        schema_view.with_ui("redoc", cache_timeout=0),
        name="schema-redoc",
    ),
    path("accounts/", include(("okta_oauth2.urls", "okta_oauth2"), namespace="okta_oauth2")),
    path("department_list/", views.department_list, name="department_list"),
    path("software_list/", views.software_list, name="software_list"),
    path(
        "software_by_department/<int:department_id>/",
        views.software_by_department,
        name="software_by_department",
    ),
    path("success/", views.success, name="success"),
    path("request_access/", request_access_view, name="request_access"),
    path("request_software/<int:software_id>/", views.request_software, name="request_software"),
    path("request_list/", views.request_list, name="request_list"),
    # Our app's urls here
    # path('/', include('autron.urls')),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

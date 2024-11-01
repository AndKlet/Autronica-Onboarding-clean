from rest_framework import serializers

from .models import Department, Request, Software


class DepartmentSerializer(serializers.ModelSerializer):
    id = serializers.IntegerField()
    name = serializers.CharField(max_length=100)

    class Meta:
        model = Department
        fields = "__all__"


class SoftwareSerializer(serializers.ModelSerializer):
    id = serializers.IntegerField()
    name = serializers.CharField(max_length=100)
    department = DepartmentSerializer()
    image = serializers.ImageField(required=False)
    description = serializers.CharField(max_length=500)
    requestmethod = serializers.CharField(max_length=50)

    class Meta:
        model = Software
        fields = "__all__"


class RequestSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    software = SoftwareSerializer()
    # request_date = serializers.DateTimeField()
    status = serializers.CharField(max_length=100)

    class Meta:
        model = Request
        fields = "__all__"

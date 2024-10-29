from rest_framework import serializers

from .models import Department, Software


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

    class Meta:
        model = Software
        fields = "__all__"

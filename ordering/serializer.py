from rest_framework import serializers


class OrderSerializer(serializers.Serializer):
    user_id = serializers.IntegerField()
    product = serializers.CharField(max_length=100)
    count = serializers.IntegerField(default=0)
    address = serializers.CharField(max_length=1000)

class OrderStatusSerializer(serializers.Serializer):
    user_id = serializers.IntegerField()
    status = serializers.CharField(max_length=100)

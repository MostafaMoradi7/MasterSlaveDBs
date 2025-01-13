from rest_framework.response import Response
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.permissions import AllowAny
from .serializer import OrderSerializer, OrderStatusSerializer
from django.shortcuts import get_object_or_404
from .models import User, Order
import logging

class Ordering(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        data = request.data
        serializer = OrderSerializer(data=data)
        if serializer.is_valid():
            order_data = serializer.validated_data
            user = get_object_or_404(User, id=order_data['user_id'])
            try:
                order = Order.objects.create(
                    user=user,
                    product=order_data['product'],
                    count=order_data['count'],
                    address=order_data['address']
                )
                return Response(status=status.HTTP_200_OK, data={"order_id": order.id})
            except Exception as e:
                logging.error(e)
                return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST, data=serializer.errors)

    def put(self, request, order_id):
        order = get_object_or_404(Order, id=order_id)
        data = request.data
        serializer = OrderStatusSerializer(data=data)
        if serializer.is_valid():
            user = get_object_or_404(User, id=data['user_id'])
            if not user.admin:
                return Response(status=status.HTTP_400_BAD_REQUEST, data={"message" : "only admins can change order status"})
            else:
                order.status = serializer.validated_data['status']
                return Response(status=status.HTTP_200_OK, data=serializer.data)
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST, data=serializer.errors)

    def get(self, order_id):
        order = get_object_or_404(Order, id=order_id)
        return Response(status=status.HTTP_200_OK, data=order.status)

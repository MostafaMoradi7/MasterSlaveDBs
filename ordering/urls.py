from django.urls import path
from . import views

urlpatterns = [
    path('orders/', views.Ordering.as_view(), name='register-order'),
    path('orders/<str:order_id>/', views.Ordering.as_view(), name='change-order-status'),
    path('orders/<str:order_id>/status', views.Ordering.as_view(), name='show-order-status'),
    path('user/', views.UserView.as_view(), name='user-order'),
]
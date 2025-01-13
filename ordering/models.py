from django.db import models
from uuid import uuid4

class User(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    admin = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.id}. {self.first_name}-{self.last_name}"



class Order(models.Model):
    STATUS_CHOICES = [
        ("pending", 'Pending'),
        ("approved", 'Approved'),
        ("rejected", 'Rejected'),
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.CharField(max_length=100)
    count = models.PositiveIntegerField(default=0)
    address = models.TextField()
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default="pending")
    created_at = models.DateTimeField(auto_now_add=True)
    id = models.UUIDField(primary_key=True, default=uuid4, editable=False, unique=True)

    def __str__(self):
        return f"{self.id}. {self.product}-{self.user.first_name}-{self.user.last_name}"


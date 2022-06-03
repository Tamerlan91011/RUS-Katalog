from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.renderers import JSONRenderer
from .models import *
from .serializers import CategorySerializer


class CategoryAPIView(APIView):
    def get(self, request):
        categories = list(Category.objects.all().values())
        print(categories[1])
        serializer = CategorySerializer(categories, many=True)
        return Response(b'\"categories\" :' + JSONRenderer().render(serializer.data))

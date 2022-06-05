from rest_framework.views import APIView
from rest_framework.response import Response
from django.http.response import FileResponse
from .models import *

MEDIA_DIR = "./images/"


class MediaAPIView(APIView):
    def get(self, request):
        object_id = request.query_params.get('object_id')
        object_type = request.query_params.get('object_type')
        if not object_id and not object_type:
            return Response({'error': 'Отстуствует один из параметров: object_id или object_type'})
        try:
            media = Media.objects.get(objectID=object_id, objectType=object_type)
            return FileResponse(open(f"{MEDIA_DIR}{media.filename}", 'rb'), filename=media.filename)
        except Exception as ex:
            print(ex)
            return Response({'error': 'Медиа файлы не найдены'})

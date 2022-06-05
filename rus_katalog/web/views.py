from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.renderers import JSONRenderer
from .serializers import *


class CategoryAPIView(APIView):
    def get(self, request):
        categories = list(Category.objects.all().values())
        serializer = CategorySerializer(categories, many=True)
        return Response(JSONRenderer().render(serializer.data))


class ProductAPIView(APIView):
    def get(self, request):
        product_id = request.query_params.get('product_id')
        products_id = request.query_params.getlist('products_id')
        category_id = request.query_params.get('category_id')
        if not product_id and not category_id and len(products_id) < 1:
            return Response({'error': 'Отстуствует один из параметров: product_id или products_id или category_id'})
        try:
            if product_id is not None:
                product = Product.objects.get(id=product_id)
                specList = SpecificationToProduct.objects.filter(product=product_id)
                productSerializer = ProductSerializer(product)
                specSerializer = SpecificationToProductSerializer(specList, many=True)
                return Response(b'[{\"product\": ' + JSONRenderer().render(productSerializer.data) + b'}, {\"specList\": ' +
                                JSONRenderer().render(specSerializer.data) + b'}]')
            if len(products_id) > 0:
                products = []
                for id in products_id:
                    product = Product.objects.filter(id=id)
                    products.append(product[0])
                serializer = ProductSerializer(products, many=True)
                return Response(b'\"products\": ' + JSONRenderer().render(serializer.data))
            if category_id is not None:
                products = Product.objects.filter(category=category_id)
                serializer = ProductSerializer(products, many=True)
                return Response(b'\"products\": ' + JSONRenderer().render(serializer.data))
        except Exception as ex:
            print(ex)
            return Response({'error': 'Товар не найден'})


class SpecificationAPIView(APIView):
    def get(self, request):
        specifications = Specification.objects.all().values()
        serializer = SpecificationSerializer(specifications, many=True)
        return Response(JSONRenderer().render(serializer.data))

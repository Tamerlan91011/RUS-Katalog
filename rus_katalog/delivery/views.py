import random

from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.renderers import JSONRenderer
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate
from .serializers import *




class PriceAPIView(APIView):
    def get(self, request):
        product_id = request.query_params.get('product_id')
        products_id = request.query_params.getlist('products_id')
        shops_id = request.query_params.getlist('shops_id')
        if not product_id and len(shops_id) < 1 and len(products_id) < 1:
            return Response({'error': 'Отстуствует один из параметров: product_id или products_id или shops_id'})
        try:
            if product_id is not None:
                pio = ProductsInShops.objects.filter(product_id=product_id).order_by('price')
                serializer = ProductsInShopsSerializer(pio, many=True)
                return Response(JSONRenderer().render(serializer.data))
            elif len(products_id) > 0 and len(shops_id) < 1:
                pio = []
                for index in range(len(products_id)):
                    try:
                        pio.append(ProductsInShops.objects.filter(product_id=products_id[index]).order_by('price')[0])
                    except:
                        pio.append(None)
                serializer = MinPricesSerializer(pio, many=True)
                return Response(JSONRenderer().render(serializer.data))
            else:
                if len(products_id) != len(shops_id):
                    return Response({'error': "Количество аргументов products_id и shops_id должно быть равным"})
                pio = []
                for index in range(len(products_id)):
                    try:
                        pio.append(ProductsInShops.objects.get(product_id=products_id[index], shop=shops_id[index]))
                    except:
                        pio.append(None)
                serializer = MinPricesSerializer(pio, many=True)
                return Response(JSONRenderer().render(serializer.data))
        except Exception as ex:
            print(ex)
            return Response({'error': 'Цены не найдены'})


class ShopAPIView(APIView):
    def get(self, request):
        shops_id = request.query_params.getlist('shops_id')
        if len(shops_id) < 1:
            return Response({'error': 'Отстуствует параметр shops_id'})
        try:
            shops = []
            for id in shops_id:
                shops.append(Shop.objects.get(id=id))
            serializer = ShopSerializer(shops, many=True)
            return Response(JSONRenderer().render(serializer.data))
        except Exception as ex:
            print(ex)
            return Response({'error': 'Цены не найдены'})


class RatingAPIView(APIView):
    def get(self, request):
        products_id = request.query_params.getlist('products_id')
        if len(products_id) < 1:
            return Response({'error': 'Отстуствует параметр shops_id'})
        try:
            rating = []
            for product in products_id:
                pio = ProductsInOrders.objects.filter(product_id=product).values()
                sum = 0.
                count = 0
                for item in pio:
                    try:
                        rate = Feedback.objects.get(pio=item['id'])
                        field_value = rate.rating
                        sum += field_value
                        count += 1
                    except Exception as ex:
                        print(ex)
                rating.append(sum/len(pio))
            return Response(JSONRenderer().render({'rating': rating}))
        except Exception as ex:
            print(ex)
            return Response({'error': 'Оценки не найдены'})


class FeedbackAPIView(APIView):
    def get(self, request):
        product_id = request.query_params.get('product_id')
        if not product_id:
            return Response({'error': 'Отстуствует параметр product_id'})
        try:
            pio = ProductsInOrders.objects.filter(product_id=product_id).values()
            pio_id = []
            for item in pio:
                field_value = item['id']
                pio_id.append(field_value)
            feedbacks = Feedback.objects.filter(pio__in=pio_id)
            serializer = FeedbackSerializer(feedbacks, many=True)
            return Response(JSONRenderer().render(serializer.data))
        except Exception as ex:
            print(ex)
            return Response({'error': 'Отзывы не найдены'})


class LoginAPIView(APIView):
    def get(self, request):
        if request.auth is None:
            return Response({'error': 'Токен не найден'})
        try:
            token = Token.objects.get(key=request.auth)
            user = User.objects.get(id=token.user_id)
            client = Client.objects.get(phone=user.username)
            serializer = ClientFullSerializer(client)
            return Response(JSONRenderer().render(serializer.data))
        except Exception as ex:
            print(ex)
            return Response({'error': 'Токен не найден'})

    def post(self, request):
        phone = request.query_params.get('phone')
        email = request.query_params.get('email')
        if not phone and not email:
            return Response({'error': 'Отстуствует один из параметров: phone или email'})
        if phone is not None:
            user = authenticate(username=request.data['phone'], password=request.data['password'])
            if user is None:
                return Response({'error': 'Пользователь не найден'})
        else:
            try:
                client = Client.objects.get(email=request.data['email'], password=request.data['password'])
                user = authenticate(username=client.phone, password=client.password)
            except Exception as ex:
                print(ex)
                return Response({'error': 'Пользователь не найден'})
        token = Token.objects.get_or_create(user=user)
        return Response(f"{{\"token\": \"{token[0].key}\"}}".encode('utf-8'))


class LogoutAPIView(APIView):
    def get(self, request):
        try:
            Token.objects.get(key=request.auth).delete()
        except Exception as ex:
            print(ex)
            return Response({'error': 'Токен не найден'})


class RegisterAPIView(APIView):
    def post(self, request):
        serializer = ClientFullSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        user = User.objects.create_user(username=serializer.validated_data['phone'],
                                        email=serializer.validated_data['email'],
                                        password=serializer.validated_data['password'])
        token = Token.objects.create(user=user)
        return Response(f"{{\"token\": \"{token.key}\"}}".encode('utf-8'))


class AddressAPIView(APIView):
    def get(self, request):
        if request.auth is None:
            return Response({'error': 'Токен не найден'})
        try:
            token = Token.objects.get(key=request.auth)
            user = User.objects.get(id=token.user_id)
            client = Client.objects.get(phone=user.username)
            addresses = AddressesToClients.objects.filter(client=client.id)
            serializer = AddressesToClientsSerializer(addresses, many=True)
            return Response(JSONRenderer().render(serializer.data))
        except Exception as ex:
            print(ex)


class OrderAPIView(APIView):
    def get(self, request):
        if request.auth is None:
            return Response({'error': 'Токен не найден'})
        try:
            token = Token.objects.get(key=request.auth)
            user = User.objects.get(id=token.user_id)
            client = Client.objects.get(phone=user.username)
            orders = Orders.objects.filter(client=client.id)
            pio = []
            for order in orders:
                pio.extend(ProductsInOrders.objects.filter(order=order.id))
            serializer = ProductsInOrdersOfClientSerializer(pio, many=True)
            return Response(JSONRenderer().render(serializer.data))
        except Exception as ex:
            print(ex)
            return Response({'error': 'Заказы не найдены'})

    def post(self, request):
        if request.auth is None:
            return Response({'error': 'Токен не найден'})
        try:
            token = Token.objects.get(key=request.auth)
            user = User.objects.get(id=token.user_id)
            client = Client.objects.get(phone=user.username)
            courier = Courier.objects.filter(status="свободен")
            if len(courier) < 1:
                courier = Courier.objects.all()
                courier = courier[random.randint(0, len(courier-1))]
            else:
                courier = courier[0]
            addressSerializer = AddressSerializer(data=request.data['address'])
            addressSerializer.is_valid(raise_exception=True)
            address = Address(**addressSerializer.validated_data)
            new_address = request.query_params.get('new_address')
            if new_address:
                address = addressSerializer.save()
            order_data = {
                "courier": courier.id,
                "client": client.id,
                "status": "принят в обработку",
                "delivery_address": str(address)
            }
            orderSerializer = OrderFullSerializer(data=order_data)
            orderSerializer.is_valid(raise_exception=True)
            order = orderSerializer.save()
            products_id = request.query_params.getlist('products_id')
            shops_id = request.query_params.getlist('shops_id')
            amount = request.query_params.getlist('amount')
            if len(products_id) < 1 or len(shops_id) < 1 or len(amount) < 1:
                return Response({'error': 'Отсутствует один из параметров: products_id или shops_id'})
            elif len(products_id) != len(shops_id) or len(products_id) != len(amount) or len(amount) != len(shops_id):
                return Response({'error': "Количество аргументов products_id, shops_id и amount должно быть равным"})
            for index in range(len(products_id)):
                pio_data = {
                    "order": order.id,
                    "product": products_id[index],
                    "shop": shops_id[index],
                    "amount": amount[index]
                }
                pioSerializer = ProductsInOrdersFullSerializer(data=pio_data)
                pioSerializer.is_valid(raise_exception=True)
                pioSerializer.save()
            return Response(JSONRenderer().render(orderSerializer.data))
        except Exception as ex:
            print(ex)
            return Response({'error': 'Ошибка создания заказа'})

all:
	docker compose -f docker-compose.yml up --build -d 

logs:
	docker logs attacker

clean:
	docker compose -f docker-compose.yml stop

fclean: clean
	docker compose -f docker-compose.yml down
	docker compose -f docker-compose.yml rm

re: fclean all

attacker:
	docker exec -it attacker /bin/zsh

.Phony: all logs clean fclean
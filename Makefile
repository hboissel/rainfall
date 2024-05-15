all:
	docker compose -f docker-compose.yml up --build -d 

logs:
	docker logs attacker

stop:
	docker compose -f docker-compose.yml stop 

clean: stop
	docker compose -f docker-compose.yml down

fclean: clean
	docker system prune -af

re: fclean all

attacker:
	docker exec -it attacker /bin/bash

.Phony: all logs clean fclean
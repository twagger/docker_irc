# COMMANDS
################################################################################
RM			= rm -f
RMRF		= rm -rf
CD			= cd
MKDIR		= mkdir
DOCKER		= docker
DOCKERIMG	= docker image
DCOMPOSE	= docker compose
REPLACE		= sed -i

# SOURCES
################################################################################
ENVFILE		= .env
DCOMPOSEDEV	= docker-compose.yml

# EXECUTABLES & LIBRARIES
################################################################################
NAME		= irc_server

# DIRECTORIES
################################################################################
SRCS		= ./srcs
DATABIND	= /home/twagner/irc

# FLAGS
################################################################################
FLAGENV		= --env-file
FLAGFILE	= -f
UP			= up -d
DOWN		= down
REMOVEIMGS	= --rmi all --remove-orphans

# DNS
################################################################################
ADDRESS		= 127.0.0.1 

# RULES
################################################################################
$(NAME):	
			sudo $(MKDIR) $(DATABIND)
			$(CD) $(SRCS) && $(DCOMPOSE) $(FLAGENV) $(ENVFILE) $(UP)

all:		$(NAME)

clean:
			$(CD) $(SRCS) && $(DCOMPOSE) $(DOWN) $(REMOVEIMGS)

fclean:		clean	
			$(DOCKER) system prune --all --force --volumes
			$(DOCKER) network prune --force
			$(DOCKER) volume prune --force
			$(DOCKER) image prune --force
			sudo $(RMRF) $(DATABIND)

re:			fclean all

.PHONY:		all clean fclean re
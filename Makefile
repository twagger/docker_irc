# COMMANDS
################################################################################
RM			= rm -f
RMRF		= rm -rf
CD			= cd
CAT			= cat
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
IRCCONF		= ./srcs/requirements/irc/conf
DATABIND	= ~/irc
SSH			= ~/.ssh

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
			sudo $(CAT) $(SSH)/id_rsa > $(IRCCONF)/id_rsa
			sudo $(CAT) $(SSH)/id_rsa.pub > $(IRCCONF)/id_rsa.pub
			$(CD) $(SRCS) && $(DCOMPOSE) $(FLAGENV) $(ENVFILE) $(UP)

all:		$(NAME)

clean:
			$(CD) $(SRCS) && $(DCOMPOSE) $(DOWN) $(REMOVEIMGS)
			$(RMRF) $(IRCCONF)/id_rsa
			$(RMRF) $(IRCCONF)/id_rsa.pub

fclean:		clean	
			$(DOCKER) system prune --all --force --volumes
			$(DOCKER) network prune --force
			$(DOCKER) volume prune --force
			$(DOCKER) image prune --force
			sudo $(RMRF) $(DATABIND)

re:			fclean all

.PHONY:		all clean fclean re

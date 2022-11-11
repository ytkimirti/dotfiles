FROM ubuntu:18.04

RUN apt update \
&& apt install -y software-properties-common \
&& apt update \
&& apt install -y \
curl git \
gcc g++ make autogen \
valgrind \
python3

RUN apt-add-repository ppa:fish-shell/release-3 \
&& apt update && apt install -y fish

# RUN apt-add-repository ppa:neovim-ppa/unstable \
# && apt update && apt install -y neovim

# && rm -rf /var/lib/apt/lists/*


# RUN echo '/usr/local/bin/fish' >> 'etc/shells' \
# && chsh -s '/usr/local/bin/fish'

WORKDIR /root

COPY . dotfiles

# RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
# | grep '"tag_name":' \
# |  sed -E 's/.*"v*([^"]+)".*/\1/')

CMD [ "fish" ]

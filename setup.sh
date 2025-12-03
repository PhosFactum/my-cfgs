#!/bin/bash

# Переменные
REPO_URL="https://github.com/PhosFactum/my-cfgs"
CFG_DIR="$HOME/.my-cfgs"
BIN_DIR="$HOME/.bin"
CONFIG_DIR="$HOME/.config"
XDG_CONFIG="$CFG_DIR/System/user-dirs.dirs"
DOWNLOAD_DIR="$HOME/Downloads"

# Новые пути для XDG-директорий
declare -A XDG_PATHS=(
  ["DESKTOP"]="$HOME/.Others/Desktop"
  ["DOWNLOAD"]="$HOME/Downloads"
  ["TEMPLATES"]="$HOME/.Others/Templates"
  ["PUBLICSHARE"]="$HOME/.Others/Public"
  ["DOCUMENTS"]="$HOME/.Others/Documents"
  ["MUSIC"]="$HOME/.Media/Music"
  ["PICTURES"]="$HOME/.Media/Pictures"
  ["VIDEOS"]="$HOME/.Media/Videos"
)

# Функция для создания директорий
create_directories() {
  for dir in "${XDG_PATHS[@]}"; do
    echo "Создаём директорию $dir..."
    mkdir -p "$dir"
  done
}

# Удаление старых русифицированных директорий XDG
for old_dir in "$HOME/Рабочий стол" "$HOME/Загрузки" "$HOME/Шаблоны" "$HOME/Документы" "$HOME/Видео" "$HOME/Изображения" "$HOME/Общедоступные" "$HOME/Музыка"; do
  if [ -d "$old_dir" ]; then
    echo "Удаляем старую директорию $old_dir..."
    rm -rf "$old_dir"
  fi
done

# 1. Обновление системы
echo "Обновляем систему..."
sudo pacman -Sy --noconfirm  # Обновление базы пакетов менеджера
sudo pacman -Syu --noconfirm # Обновление всей системы

# 2. Установка необходимых пакетов
echo "Устанавливаем необходимые пакеты..."
sudo pacman -S --noconfirm --needed fakeroot base-devel vim yay git zsh bat tmux gdb telegram-desktop xclip

# Проверка на установку каждого пакета
if ! command -v fakeroot &>/dev/null; then
  echo "Ошибка при установке fakeroot."
fi

if ! command -v vim &>/dev/null; then
  echo "Ошибка при установке vim."
fi

if ! command -v yay &>/dev/null; then
  echo "Ошибка при установке yay."
fi

if ! command -v git &>/dev/null; then
  echo "Ошибка при установке git."
fi

if ! command -v zsh &>/dev/null; then
  echo "Ошибка при установке zsh."
fi

if ! command -v bat &>/dev/null; then
  echo "Ошибка при установке bat."
fi

if ! command -v tmux &>/dev/null; then
  echo "Ошибка при установке tmux."
fi

if ! command -v telegram-desktop &>/dev/null; then
  echo "Ошибка при установке telegram-desktop."
fi

if ! command -v xclip &>/dev/null; then
  echo "Ошибка при установке xclip."
fi

# 3. Установка zathura через yay
echo "Устанавливаем zathura через yay..."
yay -S --noconfirm zathura

# 4. Создание XDG-директорий
echo "Создаём XDG-директории..."
create_directories

# Подключение пользовательского user-dirs.dirs
if [ -f "$XDG_CONFIG" ]; then
  echo "Создаём символическую ссылку на user-dirs.dirs..."
  mkdir -p "$HOME/.config"
  ln -sf "$XDG_CONFIG" "$HOME/.config/user-dirs.dirs"
else
  echo "Файл user-dirs.dirs не найден в репозитории!"
fi

# 6. Создание символических ссылок для конфигов
echo "Создаём символические ссылки для конфигурационных файлов..."
ln -sf "$CFG_DIR/Shell/.bashrc" "$HOME/.bashrc"
ln -sf "$CFG_DIR/Shell/.zshrc" "$HOME/.zshrc"
sudo ln -sf "$CFG_DIR/Keyboard/kbct.yaml" "/etc/kbct.yaml"

# 7. Создание ссылок на скрипты в .bin
echo "Создаём символические ссылки для скриптов из Shell/bin..."
mkdir $HOME/.bin
ln -s $CFG_DIR/Shell/.bin/* $BIN_DIR/

# 8. Создание ссылок на директории для nvim
echo "Создаём символические ссылки для nvim..."
cp -r "$CFG_DIR/Editor/nvim" "$CONFIG_DIR/nvim"

# Установка lazy.nvim, если еще не установлено
echo "Устанавливаем lazy.nvim..."
if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/lazy.nvim" ]; then
  git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/packer/start/lazy.nvim
fi

# Синхронизация плагинов через lazy.nvim
echo "Синхронизируем плагины через lazy.nvim..."
nvim +LazySync +qa

# 9. Запуск настройки kbct из скрытого скрипта
echo "Настроим kbct с помощью скрытого скрипта..."
bash "$HOME/.my-cfgs/Shell/bin/kbct.sh"


# Завершение
echo "Для создания шортката для переключения тачпада в GNOME, введите следующую команду в настройках клавиатуры (в разделе 'Горячие клавиши' -> 'Добавить'):"
echo "$HOME/.bin/toggle-touchpad"

# Удаляем директорию my-cfgs
echo "Удаляем директорию $HOME/my-cfgs..."
mv "$HOME/my-cfgs" "$HOME/.my-cfgs"

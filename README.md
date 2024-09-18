# AdGuard Home Keenetic 4.2 beta 3

> [!NOTE]
> AdGuard Home – это DNS-сервер, блокирующий рекламу и трекинг. Его цель – дать вам возможность контролировать всю вашу сеть и все подключённые устройства. Он не требует установки клиентских программ.

<br>

## Установка AdGuard Home
1. Подключитесь к вашему устройству с **Entware** по SSH под пользователем **root**.
2. Выполните команду:

```bash
curl -L -o install_adguardhome.sh https://github.com/Corvus-Malus/AdGuardHome/raw/main/Installer/install_adguardhome.sh
```

3. Сделайте скрипт исполняемым:

```bash
chmod +x install_adguardhome.sh
```

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/install-1.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/install-1.png">
    </picture>
</p>

<br>

5. Запустите скрипт для установки AdGuard Home:

```bash
./install_adguardhome.sh install
```
<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/install-2.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/install-2.png">
    </picture>
</p>

<br>

6. Отключите встроенный DNS-сервер прошивки Keenetic. [Подключитесь к CLI](http://192.168.1.1/webcli/parse) (не путайте с SSH-сервером из Entware, который работает на порту 222): http://192.168.1.1/webcli/parse

> **Примечание**: *После этого пропадёт доступ в Интернет, это нормально (ведь родной dns-proxy кинетика вы только что отключили, а AdGuard Home займёт его место лишь после прохождения первоначальной настройки).*

```bash
opkg dns-override
```

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/dns-override.jpg">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/dns-override.png">
    </picture>
</p>

<br>

```bash
system configuration save
```

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/dns-override-save.jpg">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/dns-override-save.jpg">
    </picture>
</p>

<br>

7. НЕ игнорировать DNSv4 интернет-провайдера

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/ethernet.png">
      <img width="100%" height="100%" src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/ethernet.png">
    </picture>
</p>

<br>

8. Оставляем только DNSv4 интернет-провайдера

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/dns.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/dns.png">
    </picture>
</p>

Откройте в браузере мастер первоначальной настройки AdGuard Home по адресу `http://IP-адрес-роутера:3000`. В дальнейшем будем считать, что этот адрес — http://192.168.1.1:3000

Произведите первоначальную настройку. Веб-интерфейс повесьте на **Все интерфейсы**, порт **3000**, DNS-сервер повесьте на **Все интерфейсы**, порт **53**. Также придумайте логин и пароль (чтобы не усложнять, можно использовать логин/пароль от админки роутера).

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/Step-1.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/step-1.png">
    </picture>
</p>

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/Step-2.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/step-2.png">
    </picture>
</p>

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/Step-3.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/step-3.png">
    </picture>
</p>

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/Step-4.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/step-4.jpg">
    </picture>
</p>

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/Step-5.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/step-5.png">
    </picture>
</p>

<br>

Зайдите по адресу `http://IP-адрес-роутера:3000` (в нашем примере — http://192.168.1.1:3000) и настройте остальное (подписки, фильтры, upstream DNS) по вкусу.

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/DNS-1.jpg">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/DNS-1.png">
    </picture>
</p>

<br><br>

## Рекомендуемые Bootstrap DNS-серверы:

`1.1.1.1`

`1.0.0.1`

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/DNS-2.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/DNS-2.png">
    </picture>
</p>

<br><br>

## Рекомендация: Включите **DNSSEC** для дополнительной безопасности.

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/DNS-3.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/DNS-3.png">
    </picture>
</p>

<br><br>

## Включаем черные списки DNS

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/DNS-4.jpg">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/DNS-4.png">
    </picture>
</p>

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/DNS-5.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/DNS-5.png">
    </picture>
</p>

`/opt/etc/init.d/S99adguardhome (start|stop|restart|check|status|kill|reconfigure)`

<br><br>

## Лайфхак по доступу к tmdb и другим ресурсам:

> *Прописал в роутинг сайты themoviedb.org и tmdb.org, но они всё равно не открываются. Почему и, как получить к ним доступ?*

Вы можете направить выборочно ресурсы **tmdb** на **quad9** или на другой правильный DNS, а для остальных ресурсов пользоваться привычными DNS-серверами. Пример на скриншоте:

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/DNS-22.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/DNS-22.png">
    </picture>
</p>

<br>

Получение доступа к ИИ-сервисам (ChatGPT, Microsoft Copilot, Google Gemini) из России

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/DNS-11.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/DNS-11.png">
    </picture>
</p>

<br><br>

## Удаление AdGuard Home

Для удаления AdGuard Home выполните:

```bash
/opt/etc/init.d/S99adguardhome stop
```

```bash
./install_adguardhome.sh uninstall
```

<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Dark/unistall.png">
      <img src="https://github.com/Corvus-Malus/XKeen-docs/raw/main/images/AdGuardHome/Light/unistall.png">
    </picture>
</p>

---

Тест: https://test.adminforge.de/adblock.html

Тест: https://d3ward.github.io/toolz/adblock.html

Источник: https://adguard.com/ru/adguard-home/overview.html

https://github.com/AdguardTeam/AdGuardHome/releases

Известные DNS-провайдеры: https://adguard-dns.io/kb/ru/general/dns-providers

https://github.com/curl/curl/wiki/DNS-over-HTTPS

<br>

Платное решение по блокировке рекламы без установки на роутер (1500₽ в год): https://adguard-dns.io/ru и https://nextdns.io

> *В бесплатной версии доступно до 300 тыс. DNS-запросов в месяц, в платной — до 10 млн запросов в месяц.*


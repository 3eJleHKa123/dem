# SysAdminCheat

Мини-шпаргалка для сисадмина под Windows: удерживаешь `F12` — появляется окно, отпускаешь `F12` — окно закрывается. Страницы переключаются стрелками или клавишами `1/2/3/4`.

## Установка одной командой

После загрузки проекта на GitHub замени `USER/REPO` в `install.ps1` на свой репозиторий.

Команда установки:

```powershell
powershell -ExecutionPolicy Bypass -Command "iwr https://raw.githubusercontent.com/USER/REPO/main/install.ps1 | iex"
```

## Как получить exe

1. Загрузи проект в GitHub.
2. Открой Actions → Build Windows EXE → Run workflow.
3. Скачай artifact `SysAdminCheat.exe`.
4. Для установки через ссылку положи `SysAdminCheat.exe` в Releases с именем `SysAdminCheat.exe`.

## Что редактировать

Основные подсказки сейчас находятся в `src/SysAdminCheat.ahk` в функции `LoadPages()`.

## Удаление

```powershell
powershell -ExecutionPolicy Bypass -File .\uninstall.ps1
```

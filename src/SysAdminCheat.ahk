#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir A_ScriptDir

; SysAdmin Cheat Overlay
; Hold F12 to show. Use Left/Right or 1/2/3/4 to switch pages. Release F12 to hide.
; Edit commands.json or replace pages below.

global CurrentPage := 1
global Pages := LoadPages()
global GuiObj := CreateCheatGui()

F12::ShowCheat()
F12 Up::HideCheat()
#HotIf WinExist("ahk_id " GuiObj.Hwnd)
Left::PrevPage()
Right::NextPage()
1::SetPage(1)
2::SetPage(2)
3::SetPage(3)
4::SetPage(4)
Esc::HideCheat()
#HotIf

LoadPages() {
    defaultPages := [
        Map("title", "Модуль 1: сеть", "items", [
            "Имена: hostnamectl set-hostname hq-srv.au-team.irpo",
            "IP: nmcli con mod <conn> ipv4.addresses <ip>/<mask> ipv4.gateway <gw>",
            "SSH порт: Port 2012; AllowUsers sshuser; MaxAuthTries 2",
            "NAT Linux: iptables -t nat -A POSTROUTING -o <wan> -j MASQUERADE",
            "DHCP: DNS=hq-srv, suffix=au-team.irpo"
        ]),
        Map("title", "Модуль 2: службы", "items", [
            "Samba DC: samba-tool domain provision --realm=AU-TEAM.IRPO",
            "RAID5: mdadm --create /dev/md2 --level=5 --raid-devices=3 /dev/sd[b-d]",
            "NFS: /raid/nfs <cli-net>(rw,sync,no_subtree_check)",
            "Ansible ping: ansible all -m ping -i /etc/ansible/hosts",
            "Docker compose: site + db, порт 8082"
        ]),
        Map("title", "Модуль 3: защита", "items", [
            "CA: сертификаты для web.au-team.irpo и docker.au-team.irpo",
            "Firewall: разрешить http/https/dns/ntp/icmp, остальное запретить",
            "rsyslog: warning+ в /opt/<hostname>/",
            "fail2ban: maxretry=3, bantime=3m, port=2012",
            "Backup: /etc и webdb на /backup"
        ]),
        Map("title", "Быстрые проверки", "items", [
            "ip a / ip r / ss -tulpn",
            "systemctl status <service>",
            "journalctl -u <service> -xe",
            "dig @<dns> hq-srv.au-team.irpo",
            "curl -I http://web.au-team.irpo:8082"
        ])
    ]
    return defaultPages
}

CreateCheatGui() {
    g := Gui("+AlwaysOnTop -Caption +ToolWindow +Border")
    g.BackColor := "1E1E1E"
    g.SetFont("s11 cFFFFFF", "Segoe UI")
    g.AddText("vTitle w560 h28 Center BackgroundTrans", "")
    g.SetFont("s10 cDCDCDC", "Consolas")
    g.AddEdit("vBody w560 h245 ReadOnly -VScroll", "")
    g.SetFont("s9 cAAAAAA", "Segoe UI")
    g.AddText("vFooter w560 h22 Center BackgroundTrans", "←/→ страницы | 1-4 выбор | Esc закрыть | отпусти F12")
    return g
}

ShowCheat() {
    global GuiObj
    RenderPage()
    x := A_ScreenWidth - 620
    y := 80
    GuiObj.Show("x" x " y" y " w590 h330 NoActivate")
}

HideCheat() {
    global GuiObj
    GuiObj.Hide()
}

RenderPage() {
    global GuiObj, Pages, CurrentPage
    page := Pages[CurrentPage]
    body := ""
    for item in page["items"] {
        body .= "• " item "`r`n`r`n"
    }
    GuiObj["Title"].Text := page["title"] "  [" CurrentPage "/" Pages.Length "]"
    GuiObj["Body"].Value := body
}

NextPage() {
    global CurrentPage, Pages
    CurrentPage := CurrentPage >= Pages.Length ? 1 : CurrentPage + 1
    RenderPage()
}

PrevPage() {
    global CurrentPage, Pages
    CurrentPage := CurrentPage <= 1 ? Pages.Length : CurrentPage - 1
    RenderPage()
}

SetPage(n) {
    global CurrentPage, Pages
    if (n >= 1 && n <= Pages.Length) {
        CurrentPage := n
        RenderPage()
    }
}

yaml-mode

;; General
(setup "---\n- name: "(p "name" name) n>"hosts: "(p "hosts" hosts) n>"tasks: " n> q"")
(lsetup "---\n- name: "(p "name" name) n>"hosts: localhost"n>"connection: local"n>"tasks: " n> q"")
(gen "- name: "(p "name" name) n>""(p "task" task)":" " "(p "args" args) q"")
;; Tag
(t "tags: "(p "tag" tag) q"")
;; Commands
(command "- name: "(p "name" name) n>"command: "p q"")
(bcommand "- name: "(p "name" name) n>"become: true"n> "command: "p q"")
(shell "- name: "(p "name" name) n>"shell: "p q"")
(bshell "- name: "(p "name" name) n>"become: true"n> "shell: "p q"")
(script "- name: "(p "name" name) n>"script: "p q"")
(bscript "- name: "(p "name" name) n>"become: true"n> "script: "p q"")
(raw "- name: "(p "name" name) n>"raw: "p q"")
(braw "- name: "(p "name" name) n>"become: true"n> "raw: "p q"")

;; APT
(apt "- name: "(p "name" name) n>"become: true"n> "apt:"n> "pkg:"n>" ""- "p q"")
(apt_key "- name: "(p "name" name) n>"become: true"n> "apt_key:"n> "url: "p q"")
(apt_repo "- name: "(p "name" name) n>"become: true"n> "apt_repository:"n> "repo: "p q"")

;; Files
(mkdir "- name: "(p "name" name) n>"file:"n> "path: "(p "path" path) n>"state: directory"n> q"")
(touch "- name: "(p "name" name) n>"file:"n> "path: "(p "path" path) n>"state: touch"n> q"")
(copy "- name: "(p "name" name) n>"copy:"n> "src: "(p "src" src) n>"""dest: "(p "dest" dest) n> q"")
(move "- name: "(p "name" name) n>"command: ""mv "(p "removed" removed)" "(p "created" created) n>"""args: " n>"""creates: "(s created) n>"""removes: "(s removed)" "n> q"")

;; Text Editing
(lif "- name: "(p "name" name) n>"lineinfile:"n> "path: "(p "src" path) n>"""line: "(p "line" line) n> q"")
(replace "- name: "(p "name" name) n>"replace:"n> "path: "(p "src" path) n>"""regexp: "(p "regexp" regexp) n>"""replace: "(p "replace_with" replace_with) n> q"")

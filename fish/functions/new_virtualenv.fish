function new_virtualenv -d "Make a new virtualenv"
    virtualenv-2.7 --python=/usr/bin/python2.7 --no-site-packages ~/.virtualenv/$argv/
end

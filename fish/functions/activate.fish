
function activate -d "Activate virtualenv"
    if [ (count $argv) -eq 0 ]
        set new_virtualenv "khan-python27"
    else
        set new_virtualenv $argv
    end

    if [ $_virtualenv = $new_virtualenv ]
        return
    end

    if functions -q deactivate
        deactivate
    end

    set -g _virtualenv $new_virtualenv

    . ~/.virtualenv/$_virtualenv/bin/activate.fish
    true
end

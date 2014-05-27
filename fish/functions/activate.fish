
function activate -d "Activate virtualenv"
    if [ (count $argv) -eq 0 ]
        set new_virtualenv "default"
    else
        switch $argv
            case 'khan27'
                set new_virtualenv "khan27"
            case '*'
                set new_virtualenv "default"
        end
    end

    if [ $_virtualenv = $new_virtualenv ]
        return
    end

    # Setup the khan virtualenv
    if functions -q deactivate
        deactivate
    end

    set -g _virtualenv $new_virtualenv

    . ~/.virtualenv/$_virtualenv/bin/activate.fish
    test 0
end

function _virtualenv_handler --on-variable PWD
    switch $PWD
        case '/home/xymostech/khan*'
            activate khan
        case '*'
            activate default
    end
end

#!/usr/bin/env bash


opts=(
    'install'
    'template'
)

# Verifica se algum parametro foi passado
case "$@" in
    "${opts[0]}")
        # install
            check_os_family
            if [[ "$?" == 'debian' ]] ; then
                install_vb_on_debian "${VB_VERSION}"
            fi
        ;;
    "${opts[1]}")
        # template
        ;;
    *)
        echo "Opções diposníveis"
        for o in "${opts[@]}" ; do echo $o done ;
        ;;
esac
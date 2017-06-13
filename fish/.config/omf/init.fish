set -g theme_color_scheme 'user'

set ruby red

set -g __color_initial_segment_exit     brwhite red --bold
set -g __color_initial_segment_su       brwhite green --bold
set -g __color_initial_segment_jobs     brwhite blue --bold

set -g __color_path                     black white
set -g __color_path_basename            black white --bold
set -g __color_path_nowrite             $ruby white
set -g __color_path_nowrite_basename    $ruby white --bold

set -g __color_repo                     black green
set -g __color_repo_work_tree           black brblack --bold
set -g __color_repo_dirty               black red
set -g __color_repo_staged              black yellow

set -g __color_vi_mode_default          white black
set -g __color_vi_mode_insert           brgreen black
set -g __color_vi_mode_visual           red black

set -g __color_vagrant                  blue white --bold
set -g __color_username                 black blue
set -g __color_rvm                      brmagenta black --bold
set -g __color_virtualfish              brblue black --bold

fortune | cowsay -f small.cow

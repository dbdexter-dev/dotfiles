set -g theme_color_scheme 'user'

set ruby 880e4f

set -g __color_initial_segment_exit     brwhite red --bold
set -g __color_initial_segment_su       brwhite green --bold
set -g __color_initial_segment_jobs     brwhite blue --bold

set -g __color_path                     black white
set -g __color_path_basename            black white --bold
set -g __color_path_nowrite             $ruby white
set -g __color_path_nowrite_basename    $ruby white --bold

set -g __color_repo                     green black
set -g __color_repo_work_tree           brblack black --bold
set -g __color_repo_dirty               red black
set -g __color_repo_staged              yellow black

set -g __color_vi_mode_default          white black
set -g __color_vi_mode_insert           green black
set -g __color_vi_mode_visual           red black

set -g __color_vagrant                  blue white --bold
set -g __color_username                 brblack blue
set -g __color_rvm                      brmagenta black --bold
set -g __color_virtualfish              brblue black --bold

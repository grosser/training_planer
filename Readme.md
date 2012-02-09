A small app that letst you host trainings (or events etc),<br/>
admins can create them and then mass-mail participants,<br/>
participants get auto-accepted if they verify thair email (no login required).<br/>
Users without a .gov/.org email need to give a reason why they want to participate.

[Demo](http://training-planner.herokuapp.com/)

admin-login: user/user

Setup
=====

    cp config/database.example.yml config/database.yml
    cp config/config.example.ymp config/config.yml

 - install postgres (sudo apt-get install postgresql libpq-dev)
 - create databases


First, `ssh` into your server:
```bash
ssh gobs@gobs.eu
```

[Install Julia](https://ferrolho.github.io/blog/2019-01-26/how-to-install-julia-on-ubuntu).

Clone your web app repository:
```bash
cd /home/grav
git clone https://github.com/junglegobs/CountdownSolver.jl.git
cd CountdownSolver.jl
```

To run Julia in the background, use `screen` (you may have to install this e.g. using `sudo apt install screen`):

```
screen -S countdown
```

Start Julia.
```bash
julia --project=@. # starts julia and sets project to repository directory
```
Within julia
```julia
] instantiate
include("src/build_web_app.jl")
```
This should produce output:
```julia
Web Server running at http://127.0.0.1:9000
```
If you're running this locally, you should be able to check in your browser that this is the case. There might also be a way of doing this if you're `ssh`'d into your server (googling "port forwarding" may be useful).

In `build_web_app.jl`, the initiation of the Stipple model is done with the keyword argument `transport = Genie.WebThreads`. This is quite important for reasons relating to web sockets (see [here](https://discourse.julialang.org/t/hello-ive-built-a-web-app-using-genie-stipple-and-i-would-like-to-deploy-it-to/54459/15)).

Leave screen using `Ctrl + A + d`. You can get back to it using `screen -dr`.

I put my reverse proxy config file in `/etc/nginx/conf.d/reverse-proxy.config`, and it looks like this:
```
server {
        listen 80;
        server_name countdown.gobs.eu;
        location / {
                proxy_pass http://127.0.0.1:9000;        
		proxy_set_header Host $http_host;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
}
```

For a while, I was confused as to why going to `countdown.gobs.eu` did nothing. Then I realised that I probably needed to update my DNS record and add an A name which pointed to my web server. This improved things - I was getting 404 errors. Eventually, I put a symbolic link at `/etc/nginx/sites-enabled/countdown` and it was all (as they say in Italy) Gucci.
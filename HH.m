function NUMB = HH(i,k,time,thresh,M,delta_t)

NUMB = 0;

dt = delta_t;
a = 0.02;
d = 8;
b = 0.2;
c = -65;
T = ceil(time/dt);

v = zeros(T,1);
u = zeros(T,1);
v(1) = -70;
u(1) = -14;


n_in = 100;
rate = 2*1e-3;
tau_g = 10;
g_in = zeros(n_in,1);
E_in = zeros(n_in,1);
w_in = M(k,i)*ones(1,n_in);

for t = 1:T-1
    
    p = rand(n_in,1)<rate*dt;
    
    g_in = g_in + p;
    Iapp = w_in*(g_in.*E_in);
    Iapp = Iapp - (w_in*g_in).*v(t);
    g_in = (1-dt/tau_g)*g_in;
    
    if v(t)<thresh
        dv = (0.04*v(t)+5)*v(t)+140-u(t);
        v(t+1) = v(t) + (dv+Iapp)*dt;
        du = a*(b*v(t)-u(t));
        u(t+1) = u(t) + dt*du;
    else
        v(t) = thresh;
        v(t+1) = c;
        u(t+1) = u(t)+d;
        NUMB=NUMB+1;
    end
end
    
end



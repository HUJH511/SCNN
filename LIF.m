

function NUMB = LIF(i,k,time,thresh,M,delta_t)
%i: time index
%k: filter index
%time: total precessing time
%thresh: thershold
%M: input signal matrix

NUMB=0;
% membrane constants
tau_m = 0.030;
Rm = 3e7;
% Time
delta_t; % Integration time step
duration = time; % duration of the simulation
No_steps = round(duration ./ delta_t);
times = linspace(0, duration, No_steps + 1); % The time points for update
% membrane potential
V_0 = 0.03; % The initial membrane potential
V = zeros(1, No_steps + 1);
V(1) = V_0;
% Injection current
Iinj = zeros(1, No_steps + 1);
for r=1:1:No_steps + 1
    Iinj(r) = M(k,i);
end
%spike
t_spikes = [];
%%%% set up PSC events
tau_s = 0.003;
% Times of PSCs

T_psc(1) = 0;
T_psc(2) = 0;
T_psc(3) = 0;
No_pscs = length(T_psc);
Q = 40e-12; % charge deliverd by a single PSC event
I_0 = Q ./ tau_s; % resulting ’normalisation’ constant for the exponential description of the PSC
index_pscs = round(T_psc ./ delta_t);
% initialise synaptic current
I_syn = zeros(1, No_steps + 1);
% noise current
std_dev_noise = 0.9e-9;
I_noise = std_dev_noise .* randn(1, No_steps);
for c=1:No_steps
    % first check for synaptic event
    for s=1:No_pscs
        if r == index_pscs(s)
            I_syn(r) = I_syn(r) + Iinj;
        end
    end
    % update the synaptic current
    I_syn(c+1) = I_syn(c) - (1 ./ tau_s) .* I_syn(c) .* delta_t;
    dV = (1 ./ tau_m) .* (-V(c) + Rm .* (I_syn(c) + Iinj(c) + I_noise(c))) .* delta_t;
    V(c+1) = V(c) + dV;
    if V(c+1) > thresh
        
        V(c+1) = 0;
        t_spikes = [t_spikes (c - 1) * delta_t];
        NUMB=NUMB+1;
    end
end
end

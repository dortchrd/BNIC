using Plots
using Random
using DataFrames
using JLD #https://github.com/JuliaIO/JLD.jl
# Generate Signal values from time inputs (ms) and T1 value   
function T1mag(t,T₁)
    M = 123411234
    Mnew = abs.(M .* (1 .- 2 .*exp.(-t /T₁)));
    return Mnew
end

# Example Plot of Funciton output and subsampled versions
t = 0:20:8000
plot(t,T1mag(t,2500))


# Create a range of T1 values and time vector
T1vals = sort(rand(500:8000,250))
TI = LinRange(0,8000,6)
#Test plot
plot(TI,T1mag(TI,T1vals[200]))
num = T1vals[200];
title!("T₁ $num")
# Generate signal Matrix of Examples
S = zeros(size(TI,1),size(T1vals,1));
for k = 1: size(T1vals,1)
    S[:,k] = T1mag(TI,T1vals[k])
end
#Test plot
plot(TI,T1mag(TI,T1vals[200]))
num = T1vals[200];
scatter!(TI,S[:,200])
title!("T₁ $num")
# Creating a dictionary to save
ExDict = Dict("T1values"=>T1vals, "InversionTimes"=>TI,"ExampleSignals"=>S)
# T1vals 250 T1 values 250,1
# Inversion Times 6 TIs from 0:8000
# ExampleSignals S Matrix of size [6,250] 6 Samples @ TI with 250 examples from T1vals
save("T1fittingdataex.jld","Dict",ExDict)  #Using JLD to save Dictionary

#A =load("T1fittingdataex.jld","Dict")   #Using JLD to load Dictionary

#Test plot to show that JLD was working
#plot(A["InversionTimes"],T1mag(TI,T1vals[67]))
#scatter!(A["InversionTimes"],A["ExampleSignals"][:,67])
#num = A["T1values"][67]
#title!("T₁= $num")
#ylabel!("Signal AU")
#xlabel!("Time (ms)")

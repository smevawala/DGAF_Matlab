% Wireless Final Project
% Shivam, Neema, Nicobitch

%Code : AODV Routing.
% clc;
clear all;
close all;
size=25;
nit=3000;
tA=zeros(1,nit);
tA1=zeros(1,nit);
len=zeros(1,nit);
len1=zeros(1,nit);
s1=1;
d1=25;
nn=18;
Mc=zeros(1,nn);
Ml=zeros(1,nn);
ks=zeros(1,nn);
h = waitbar(0,'Please wait...');
B=load('cost.mat');
% B.cost=sqrt(B.cost);
% D=load('D.mat');
% Db=D.D^2;

for hill=1:nn
k=1.1+.1*(hill-1);
y=.45;
input=[k y];
ks(hill)=k;
% A=randi([-5 1],size);
% A(A<1)=0;
% A=A.*randi([1 15],size);


for kkk=1:nit
A=2.*B.cost.*(.2*rand(25)+1);
A1=A;
A1(A>k)=A(A>k)-k;
A1(A<k&A>0)=A(A<k&A>0)*y;

 
%  disp(A);
stat=zeros(1,size);
stat(s1)=1;
dist=inf(1,size);
next=zeros(1,size);
dist(s1)=0;
% next(s1)=0;

stat1=zeros(1,size);
stat1(s1)=1;
dist1=inf(1,size);
next1=zeros(1,size);
dist1(s1)=0;
% next1(s1)=0;

 for i=1:size
    
     if A(i,s1)~=0
        dist(i)=A(i,s1);
%         disp([' node 1 sends RREQ to node ' num2str(i)])
        next(i)=s1;
     end
     
     if A1(i,s1)~=0
        dist1(i)=A1(i,s1);
%       disp([' node 1 sends RREQ to node ' num2str(i)])
        next1(i)=s1;
     end
%    disp(['i== ' num2str(i) ' A(i,1)=' num2str(A(i,1)) ' status:=' status(i) ' dist(i)=' num2str(dist(i))]);
 end
 
%  for i=1:size 
%         if A(s1,i)>0 %to all neighbors
% 
%         end
%         if A1(s1,i)>0 %to all neighbors
% 
%         end
%  end
 
 while(stat(d1)~=1)
     
    min=Inf;
    
    for i=1:size
        if stat(i)==0 && min>dist(i)
            min=dist(i);
            node=i;
        end
    end
    if min==Inf
        error('no connection')
    end
%     node
    for i=1:size
        if A(i,node)>0
           if (dist(node) + A(i,node))<dist(i)
               dist(i)=dist(node) + A(i,node);
               next(i)=node;
           end
        end
    end
     

    stat(node)=1;
    
        
 end
 
 while(stat1(d1)~=1)
     
    min=Inf;
    
    for i=1:size
        if stat1(i)==0 && min>dist1(i)
            min=dist1(i);
            node=i;
        end
    end
    if min==Inf
        error('no connection')
    end
%     node
    for i=1:size
        if A1(i,node)>0
           if (dist1(node) + A1(i,node))<dist1(i)
               dist1(i)=dist1(node) + A1(i,node);
               next1(i)=node;
           end
        end
    end
    
    stat1(node)=1;
    
        
 end
  
 
 i=d1;
 count=1;
 route=[d1];
 
 
 
 while next(i) ~=s1
%      disp([' Node ' num2str(i) ' sends RREP message to node ' num2str(next(i))])
     i=next(i);
     count=count+1;
     route=cat(2,route,i);
 end
 
 
%  disp([ ' Node ' num2str(i) ' sends RREP message to node 1'])
 

 
%  disp([' Node ' num2str(s1)])
 for i=count: -1:1
%      disp([ ' Sends message to node ' num2str(route(i))])
 end
 
 
 i=d1;
 count1=1;
 route1=[d1];
 total_A1=0;
 
  
 while next1(i) ~=s1
%      disp([' Node ' num2str(i) ' sends RREP message to node ' num2str(next1(i))])
     total_A1=total_A1+A(i,next1(i));
     i=next1(i);
     count1=count1+1;
     route1=cat(2,route1,i);

 end
 total_A1=total_A1+A(i,s1);
%   disp([' Node ' num2str(s1)])
 for i=count1: -1:1
%      disp([ ' Sends message to node ' num2str(route1(i))])
 end
 
 total_A = dist(d1);
 tA(kkk)=total_A;
 tA1(kkk)=total_A1;
 len(kkk)=length(route)+1;
 len1(kkk)=length(route1)+1;
 
end

Mc(hill)=mean((tA1-tA)./tA)
Ml(hill)=mean((len1-len)./len)

waitbar(hill/nn,h)

end 


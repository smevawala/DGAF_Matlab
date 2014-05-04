%Code : AODV Routing.
clc;
clear all;
size=20;
x=1:size;
s1=1;
d1=20;
% con=[0 0 0 1];
A=randi([-5 1],size);
A(A<1)=0;
A=A.*randi([1 15],size);

% Making matrix all diagonals=0 and A(i,j)=A(j,i),i.e. A(1,4)=a(4,1),
% A(6,7)=A(7,6)
for i=1:size
        for j=1:size
                if i==j
                    A(i,j)=0;
                else
                    A(j,i)=A(i,j);
                end
        end
end
% disp(A);
% disp(t);


 
%  disp(A);
 stat=zeros(1,20);
 stat(1)=1;
dist=inf(1,20);
% next=zeros(1,20);
dist(s1)=0;
% dist(2)=0;
next(s1)=0;
 
 for i=2:20
    
     if A(i,s1)~=0
        dist(i)=A(i,s1);
     end
%    disp(['i== ' num2str(i) ' A(i,1)=' num2str(A(i,1)) ' status:=' status(i) ' dist(i)=' num2str(dist(i))]);
 end
 
 flag=0;
 for i=2:20 
        if A(s1,i)>0 %to all neighbors
            disp([' node 1 sends RREQ to node ' num2str(i)])
                if i==d1
                       flag=1;
                end
            next(i)=s1;
        end
 end
 disp(['Flag= ' num2str(flag)]);
 
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
    node
    for i=1:size
        if A(i,node)>0
           if (dist(node) + A(i,node))<dist(i)
               dist(i)=dist(node) + A(i,node);
               next(i)=node;
           end
        end
    end
    
    
    

    stat(node)=1;
    
    
%     for i=1:20
%         if status()=='!'
%             temp=temp+1;
%         end
%     end
%     
%     if temp==20
%         break;
%     end
%     if sum(stat)==size
%         break;
%     end
        
 end
  
 i=20;
 count=1;
 route(count)=d1;
 
 
 while next(i) ~=s1
     disp([' Node ' num2str(i) ' sends RREP message to node ' num2str(next(i))])
     i=next(i);
     %disp(i);
     count=count+1;
     route(count)=i;
 end
 
 disp([ ' Node ' num2str(i) ' sends RREP message to node 1'])
 disp(' Node 1 ')
 for i=count: -1:1
     disp([ ' Sends message to node ' num2str(route(i))])
 end
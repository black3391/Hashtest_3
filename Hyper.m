function[HyperGraph]=Hyper(graph)
%Marcos Bolaños
%Michigan State University
%Updated May 2, 2010

%This program converts a binary undirected adjacency graph into a
%hypergraph. The output is a non symmetric matrix where the columns are
%the vertices and the rows are the hyper edges.

%Example: Adj= [0     1     0     0     0     0     0;
%               1     0     1     1     0     1     0;
%               0     1     0     1     0     1     0;
%               0     1     1     0     0     1     0;
%               0     0     0     0     0     1     1;
%               0     1     1     1     1     0     1;
%               0     0     0     0     1     1     0];


%HyperGraph=Hyper(Adj)

%HyperGraph =

%      1     1     0     0     0     0     0
%      0     1     1     1     0     1     0
%      0     0     0     0     1     1     1


N=length(graph);
EDGE=zeros(1,N+1);
for i=1:N
    seed=graph(i,:);
    mem=find(seed);
    k=length(mem);
    EDGEtemp=zeros(1,N+1);
    p=1;
    while sum(ismember(mem,EDGEtemp))~=length(mem)

         C = nchoosek(mem,k);
         [a,b]=size(C);
         for j=1:a
             
             row=C(j,:);
             
             x=ismember(mem,EDGEtemp);
             y=find(x==0);
             need=mem(y);
             
          if sum(ismember(need,row))~=0
             G=graph(row,row); Gn=length(G); Gsum=sum(G(:));
             
             if Gsum==(Gn^2-Gn)
                 EDGEtemp(p,[1:Gn+1])=[i row];
                 p=p+1;
             end
          end
          end
         
    k=k-1;
    
    end
    
 EDGE=[EDGE;EDGEtemp];   
  
end

[un un_i]=unique(sort(EDGE,2),'rows','first');    %remove repeated rows
Hgraph=EDGE(sort(un_i),:);
Hgraph(1,:)=[];


[a,b]=size(Hgraph);
Main=zeros(a,N);
for i=1:a
    row=Hgraph(i,:);
    d=find(row==0);
    row(d)=[];
    
    Main(i,row)=1;
end

HyperGraph=Main;

    



function B= schmidt(A)

% input:A=[a1,a2,...ap]



[n,p]=size(A);

B=zeros(n,p);



for i=1:n

    B(:,i)=A(:,i);  

    for j=1:i-1

        B(:,i)=B(:,i)-A(:,i)'*B(:,j)/norm(B(:,j))^2*B(:,j);  %bi

    end


    B(:,i)=B(:,i)/norm(B(:,i));


end


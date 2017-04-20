function B= schmidt(A)

% input:A=[a1,a2,...ap]

% output:��������������ľ���B

[n,p]=size(A);

B=zeros(n,p);

%�����������ļ��㹫ʽ

for i=1:n

    B(:,i)=A(:,i);  %bi�ĳ�ʼֵ

    for j=1:i-1

        B(:,i)=B(:,i)-A(:,i)'*B(:,j)/norm(B(:,j))^2*B(:,j);  %bi

    end

    %��λ��

    B(:,i)=B(:,i)/norm(B(:,i));


end


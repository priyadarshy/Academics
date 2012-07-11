H =[1 2.88 3.4048 1.74 0.4];

A4 = H;
B4 = fliplr(A4);
K4 = 0.4;

A3 =  (A4 - K4.*B4) / (1-K4^2);
A3 = A3(A3~=0);
B3 = fliplr(A3);
K3 = A3(end);

A2 =  (A3 - K3.*B3) / (1-K3^2);
A2 = A2(A2~=0);
B2 = fliplr(A2);
K2 = A2(end);

A1 =  (A2 - K2.*B2) / (1-K2^2);
A1 = A1(A1~=0);
B1 = fliplr(A1);
K1 = A1(end);

A0 =  (A1 - K1.*B1) / (1-K1^2);
A0 = A0(A0~=0);
B0 = fliplr(A0);
K0 = A0(end);

K4
K3
K2
K1
K0
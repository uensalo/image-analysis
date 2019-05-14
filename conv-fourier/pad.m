function p = pad(image, padr, padc)
[M,N] = size(image);
p = zeros(padr * 2 + M, padc *  2 + N);
p(padr + 1: M + padr, padc + 1: N + padc) = image;
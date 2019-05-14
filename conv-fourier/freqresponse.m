function f = freqresponse(image)
f = abs(fftshift(fft2(image)));
%SCRIPT I USED FOR IMAGE OUTPUTS AND WHATNOT
run('src\vlfeat\toolbox\vl_setup');
clear
goldengate_images = read_images('cs484_hw2_data\goldengate\');
fishbowl_images = read_images('cs484_hw2_data\fishbowl\');

%{
g_img_1 = goldengate_images{1}/255;
[f,d] = vl_sift(g_img_1);


hold on
imshow(g_img_1);
perm = randperm(size(f,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(f(:,sel)) ;
h2 = vl_plotframe(f(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;
h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
set(h3,'color','g') ;
%}

%{
[fa, da] = vl_sift(goldengate_images{1}/255) ;
[fb, db] = vl_sift(goldengate_images{2}/255) ;
[matches, scores] = vl_ubcmatch(da, db) ;

figure(2) ; clf ;
imagesc(cat(2, goldengate_images{1}, goldengate_images{2})) ;

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:)) + size(goldengate_images{1},2) ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fa(:,matches(1,:))) ;
fb(1,:) = fb(1,:) + size(goldengate_images{1},2) ;
vl_plotframe(fb(:,matches(2,:))) ;
axis image off ;
%}

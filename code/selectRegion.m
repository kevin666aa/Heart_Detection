% get positions of pixels within region of selected polygon
function [mask] = selectRegion(im)
    imshow(im);
    h = impoly(gca, []);
    api = iptgetapi(h);
    nextpos = api.getPosition();
    mask = poly2mask(nextpos(:, 1), nextpos(:, 2),100,100);
end


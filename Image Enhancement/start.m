
addpath('algorithms');
run = 21;
level = 4;
algorithms = {'dfdb_lshade_case_1', 'dfdb_lshade_case_2', 'dfdb_lshade_case_3', 'dfdb_lshade_case_4', 'dfdb_lshade_case_5'};

images = {'1.jpg', '2.jpg', '3.jpg' '4.jpg',  '5.jpg', '6.jpg', '7.jpg', '8.jpg', '9.jpg', '10.jpg', '11.jpg', '12.jpg',...
         '13.jpg', '14.jpg', '15.jpg', '16.jpg', '17.jpg', '18.jpg', '19.jpg', '20.jpg', '21.jpg', '22.jpg', '23.jpg', '24.jpg', '25.jpg', '26.jpg', '27.jpg', '28.jpg', '29.jpg', '30.jpg',...
         '31.jpg',	'32.jpg',	'33.jpg',	'34.jpg',	'35.jpg',	'36.jpg',	'37.jpg',	'38.jpg',	'39.jpg',	'40.jpg',	'41.jpg',	'42.jpg',	'43.jpg',	'44.jpg',	'45.jpg',...	
         '46.jpg',	'47.jpg',	'48.jpg',	'49.jpg',	'50.jpg',	'51.jpg',	'52.jpg',	'53.jpg',	'54.jpg',	'55.jpg',	'56.jpg',	'57.jpg',	'58.jpg',	'59.jpg',	'60.jpg',...	
         '61.jpg',	'62.jpg',	'63.jpg',	'64.jpg',	'65.jpg',	'66.jpg',	'67.jpg',	'68.jpg',	'69.jpg',	'70.jpg',	'71.jpg',	'72.jpg',	'73.jpg',	'74.jpg',	'75.jpg',...	
         '76.jpg',	'77.jpg',	'78.jpg',	'79.jpg',	'80.jpg',	'81.jpg',	'82.jpg',	'83.jpg',	'84.jpg',	'85.jpg',	'86.jpg',	'87.jpg',	'88.jpg',	'89.jpg',	'90.jpg',...	
         '91.jpg',	'92.jpg',	'93.jpg',	'94.jpg',	'95.jpg',	'96.jpg',	'97.jpg',	'98.jpg',	'99.jpg',	'100.jpg',	'101.jpg',	'102.jpg',	'103.jpg',	'104.jpg',	'105.jpg',...	
         '106.jpg',	'107.jpg',	'108.jpg',	'109.jpg',	'110.jpg',	'111.jpg',	'112.jpg',	'113.jpg',	'114.jpg',	'115.jpg',	'116.jpg',	'117.jpg',	'118.jpg',	'119.jpg',	'120.jpg'};

maxIteration = 2000 * level;

functionsNumber = length(images);
out = zeros(length(algorithms), functionsNumber, run, 3, 4);
outSolution = zeros(length(algorithms), functionsNumber, 3, level);

for i = 1 : length(algorithms)
    disp(algorithms(i));
    algorithm = str2func(algorithms{i});
    for j = 1 : functionsNumber
        disp(j);
        image = imread(strcat('Dataset/', images{j}));
        if size(image,3)==3
            image = rgb2gray(image);
        end
        [~, ~, d] = size(image);
        image=imresize(image,0.2);
        image = im2double(image);
        p = getGrayP(image);
        maxFitness = -inf;
        for k = 1 : run
           disp("run - " + k);
            [bestSolution, bestFitness, ~] = algorithm(p, level, maxIteration);
            [m, ~] = size(bestSolution);
            if(m > 1)
                bestSolution = bestSolution';
            end
            if maxFitness < bestFitness
                maxFitness = bestFitness;
                outSolution(i, j, 1, :) = bestSolution;
            end
            bestFitness = 1 / bestFitness;
            enh = transform(image,bestSolution(1),bestSolution(2),bestSolution(3),bestSolution(4));
            subplot(1,2,1);
            imshow(image);
            subplot(1,2,2);
            imshow(enh);
            psnr = getPSNR(image, enh);
            ssim = getMSSIM(image, enh);
            fsim = getFSIM(image, enh);
            out(i, j, k, 1, :) = [bestFitness, psnr, ssim, fsim];
        end

    end
        xlswrite(strcat(func2str(algorithm), '-d=', num2str(level), '.xlsx'), squeeze(outSolution(i, :, 1, :)), 'Gray-Solution');
        xlswrite(strcat(func2str(algorithm), '-d=', num2str(level), '.xlsx'), squeeze(out(i, :, :, 1, 1)), 'Gray-Fitness');
        xlswrite(strcat(func2str(algorithm), '-d=', num2str(level), '.xlsx'), squeeze(out(i, :, :, 1, 2)), 'Gray-PSNR');
        xlswrite(strcat(func2str(algorithm), '-d=', num2str(level), '.xlsx'), squeeze(out(i, :, :, 1, 3)), 'Gray-SSIM');
        xlswrite(strcat(func2str(algorithm), '-d=', num2str(level), '.xlsx'), squeeze(out(i, :, :, 1, 4)), 'Gray-FSIM');
    eD = strcat(func2str(algorithm), '-End :)');
    disp(eD);

end
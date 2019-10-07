function TheColorsOfMotion(FileName, MovieTitle, NumberOfSamples)
    video = VideoReader(FileName);
    step = floor(video.NumberOfFrames / NumberOfSamples);

    NR = 100;
    Height = NR*NumberOfSamples;
    Width = floor(Height/1.41512605);
    frames_total = zeros(Height, Width, 3, 'uint8');

    cnt = 0;
    for img = 1+step:step:video.NumberOfFrames
        cnt = cnt + 1 ;
        frame = read(video, img);

        % Extract the individual red, green, and blue color channels.
        ChannelRed = frame(:, :, 1);
        ChannelGreen = frame(:, :, 2);
        ChannelBlue = frame(:, :, 3);
        % Get means
        meanR = mean(mean(ChannelRed));
        meanG = mean(mean(ChannelGreen));
        meanB = mean(mean(ChannelBlue));

        frame_color = zeros(video.Height, video.Width, 3, 'uint8');
        frame_color(:, :, 1) = meanR;
        frame_color(:, :, 2) = meanG;
        frame_color(:, :, 3) = meanB;

        frames_total((cnt-1)*NR+1 : cnt*NR  , :, 1) = meanR;
        frames_total((cnt-1)*NR+1 : cnt*NR , :, 2) = meanG;
        frames_total((cnt-1)*NR+1 : cnt*NR , :, 3) = meanB;
        
        subplot(1,2,1), imshow(frame)
        subplot(1,2,2), imshow(frame_color)
    end
    figure
    imshow(frames_total);
    saveas(gcf,strcat(MovieTitle,'.png'))

    close all
end


classdef Smartguard_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure           matlab.ui.Figure
        SMARTGUARDLabel    matlab.ui.control.Label
        Panel              matlab.ui.container.Panel
        UploadImageButton  matlab.ui.control.Button
        EditField          matlab.ui.control.EditField
        DetectButton       matlab.ui.control.Button
        UIAxes2            matlab.ui.control.UIAxes
        UIAxes             matlab.ui.control.UIAxes
        Image              matlab.ui.control.Image
    end

    
    properties (Access = private)
        TNet=load("trainedNetwork_1.mat", "trainedNetwork_1");
        adata=double.empty;
    end
    
    methods (Access = public)
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: UploadImageButton
        function UploadImageButtonPushed(app, event)
            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Allow the user to choose an image file
            [file, path] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp', 'Image Files (*.jpg, *.jpeg, *.png, *.bmp)'}, 'Select an Image File');

            % Check if the user selected a file
            if isequal(file, 0)
                disp('User canceled the operation');
            else
                % Construct the full path to the selected image
                imagePath = fullfile(path, file);

                % Read and resize the selected image
                img = imread(imagePath);
                img = imresize(img, [227 227]);

                % Display the selected image in UIAxes
                imshow(img, 'Parent', app.UIAxes);
            end
        
        end

        % Button pushed function: DetectButton
        function DetectButtonPushed(app, event)
            global YPred;

% Check if an image is loaded in UIAxes
            if isempty(app.UIAxes.Children)
                msgbox('Please upload an image first.', 'No Image', 'warn');
                return;
            end

            % Get the image data from UIAxes
            img = app.UIAxes.Children.CData;

            % Resize the image
            img = imresize(img, [227 227]);

            % Perform image classification
            [YPred, probs] = classify(app.TNet.trainedNetwork_1, img);

            % Display results in UIAxes2
            imshow(img, 'Parent', app.UIAxes2);
            app.EditField.Value=string(YPred);

            % Draw a red box on the original image
            x = 50;      % X-coordinate of the top-left corner
            y = 50;      % Y-coordinate of the top-left corner
            width = 127; % Width of the box
            height = 127; % Height of the box
        
            hold(app.UIAxes2, 'on');  % Ensure that the box is drawn on top of the image
            rectangle(app.UIAxes2, 'Position', [x, y, width, height], 'EdgeColor', 'r', 'LineWidth', 2);
            hold(app.UIAxes2, 'off');  % Release the hold on the axis

        
        end

        % Value changed function: EditField
        function EditFieldValueChanged(app, event)
        
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [93 93 640 551];
            app.UIFigure.Name = 'MATLAB App';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.ScaleMethod = 'fill';
            app.Image.Position = [1 346 641 211];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'smartguard1_20240103_094824_0000.png');

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.Position = [4 7 634 321];

            % Create UIAxes
            app.UIAxes = uiaxes(app.Panel);
            title(app.UIAxes, 'Uploaded Image')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Box = 'on';
            app.UIAxes.Position = [8 110 300 185];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.Panel);
            title(app.UIAxes2, 'Detected Image')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Box = 'on';
            app.UIAxes2.Position = [320 110 300 185];

            % Create DetectButton
            app.DetectButton = uibutton(app.Panel, 'push');
            app.DetectButton.ButtonPushedFcn = createCallbackFcn(app, @DetectButtonPushed, true);
            app.DetectButton.Position = [95 47 127 24];
            app.DetectButton.Text = 'Detect';

            % Create EditField
            app.EditField = uieditfield(app.Panel, 'text');
            app.EditField.ValueChangedFcn = createCallbackFcn(app, @EditFieldValueChanged, true);
            app.EditField.HorizontalAlignment = 'center';
            app.EditField.FontWeight = 'bold';
            app.EditField.Placeholder = 'Detected Pest Name';
            app.EditField.Position = [384 74 196 36];

            % Create UploadImageButton
            app.UploadImageButton = uibutton(app.Panel, 'push');
            app.UploadImageButton.ButtonPushedFcn = createCallbackFcn(app, @UploadImageButtonPushed, true);
            app.UploadImageButton.VerticalAlignment = 'bottom';
            app.UploadImageButton.Position = [95 83 127 24];
            app.UploadImageButton.Text = 'Upload Image';
            app.UploadImageButton.Icon = fullfile(pathToMLAPP, 'icons8-upload-image-24.png');

            % Create SMARTGUARDLabel
            app.SMARTGUARDLabel = uilabel(app.UIFigure);
            app.SMARTGUARDLabel.HorizontalAlignment = 'center';
            app.SMARTGUARDLabel.FontSize = 24;
            app.SMARTGUARDLabel.FontWeight = 'bold';
            app.SMARTGUARDLabel.FontColor = [1 1 1];
            app.SMARTGUARDLabel.Position = [431 431 178 40];
            app.SMARTGUARDLabel.Text = 'SMARTGUARD';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Smartguard_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
# Use the official .NET 6.0 SDK image as the build environment
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy the .csproj file and restore any dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code and publish the application
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official .NET 6.0 runtime image as the runtime environment
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .

# Expose the port on which the application will run
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "bin/Debug/net6.0/Exo.WebApi.dll"]

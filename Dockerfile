FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["comc1754_netcore31_webapp.csproj", "./"]
RUN dotnet restore "comc1754_netcore31_webapp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "comc1754_netcore31_webapp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "comc1754_netcore31_webapp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "comc1754_netcore31_webapp.dll"]
